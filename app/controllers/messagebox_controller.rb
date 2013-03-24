class MessageboxController < ApplicationController

  before_filter :require_login!
  helper_method :mailbox, :conversation, :unread?
  
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


  def unread? inbox_mail
    inbox_mail.receipts.inbox.each do |rm|
      return true if rm.is_unread? and rm.message.sender != current_user
    end
    return false
  end 
end


#<Receipt id: 75, receiver_id: 2, receiver_type: "User", notification_id: 45, is_read: true, trashed: false, deleted: false, mailbox_type: "inbox", created_at: "2013-03-24 13:45:04", updated_at: "2013-03-24 13:45:04">, 
#<Receipt id: 76, receiver_id: 1, receiver_type: "User", notification_id: 45, is_read: true, trashed: false, deleted: false, mailbox_type: "sentbox", created_at: "2013-03-24 13:45:04", updated_at: "2013-03-24 13:45:04">, 
#<Receipt id: 79, receiver_id: 1, receiver_type: "User", notification_id: 47, is_read: false, trashed: false, deleted: false, mailbox_type: "inbox", created_at: "2013-03-24 14:38:08", updated_at: "2013-03-24 14:38:08">, 
#<Receipt id: 80, receiver_id: 2, receiver_type: "User", notification_id: 47, is_read: true, trashed: false, deleted: false, mailbox_type: "sentbox", created_at: "2013-03-24 14:38:08", updated_at: "2013-03-24 14:38:08">