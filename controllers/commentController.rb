require "sinatra"
require_relative '../models/comment'
include FileUtils::Verbose
class CommentController
  def create(params)
    time = Time.new  

    attachmentname = ""
  
    if params[:file]
      file = params[:file][:tempfile] 
      tempfile = params[:file]
      attachmentname = "public/uploads/"+"#{params["id_user"]}"+"#{time.to_s}"+"#{tempfile[:filename]}"
      if tempfile[:type].include?("gif") or tempfile[:type].include?("png") or  tempfile[:type].include?("jpg") or tempfile[:type].include?("mp4") or tempfile[:type].include?("pdf") or tempfile[:type].include?("doc") 
        cp(file.path, "#{attachmentname}")
      else
        return (
          {
            status: 400,
            message: "bad request with wrong file"
          }
        )
      end
    end

    comment = Comment.new(id_user: params["id_user"],id_post: params["id_post"] , comment: params["comment"], attachment: attachmentname)
   
    if !comment.valid? 
      return (
        {
          status: 400,
          message: "bad request"
        }
      )
    end    
    if comment.save
      return (
        {
          status: 201,
          message: "success"
        }
      )
    end 
  end
end