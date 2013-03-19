class MessageboxController < ApplicationController

  before_filter :require_login!
  helper_method :mailbox, :conversation
  
  def inbox    
    if params[:subject].present?
      @mail_box = current_user.mailbox.inbox.paginate(:page => params[:page_num], :per_page => 9, :conditions => ["conversations.subject LIKE ?", "%"+params[:subject]+"%"] )
    else
      @mail_box = current_user.mailbox.inbox.paginate(:page => params[:page_num], :per_page => 9 )
    end
  end

  def sent
    if params[:subject].present?
      @mail_box = current_user.mailbox.sentbox.paginate(:page => params[:page_num], :per_page => 9, :conditions => ["conversations.subject LIKE ?", "%"+params[:subject]+"%"] )
    else
      @mail_box = current_user.mailbox.sentbox.paginate(:page => params[:page_num], :per_page => 9 )
    end
  end

  def deleted
    if params[:subject].present?
      @mail_box = current_user.mailbox.trash.paginate(:page => params[:page_num], :per_page => 9, :conditions => ["conversations.subject LIKE ?", "%"+params[:subject]+"%"] )
    else
      @mail_box = current_user.mailbox.trash.paginate(:page => params[:page_num], :per_page => 9)
    end    
  end

  def create
    recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all

    conversation = current_user.send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end
  
  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end

end
