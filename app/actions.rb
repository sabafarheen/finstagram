    def current_user
        User.find_by(id: session[:user_id])
    end

def humanized_time_ago(minute_num)
    if minute_num >=60
        "#{minute_num / 60} hours ago"
    else
        "#{minute_num} minutes ago"
    end
end
  

 
 get '/' do
     @finstagram_posts = FinstagramPost.order(created_at: :desc)
     erb(:index)
end

get'/signup' do
    @user = User.new
    erb(:signup)
end

post '/signup' do
    email = params[:email]
    avatar_url = params[:avatar_url]
    username = params[:username]
    password = params[:password]
    
    #if all user params are present
   # if email.present? && avatar_url.present? && username.present? && password.present?
    
    #instantiate and save a User
    @user = User.new({email: email, avatar_url: avatar_url,username: username, password: password})
   if @user.save
       "User #{username} saved!"
    
    #return readable representation of User object
    #escape_html user.inspect
    
    else
    #display simple error message
    #escape_html user.errors.full_messages
    erb(:signup)
    end
end
    
get '/login' do
    erb(:login)
end

post '/login' do
    username = params[:username]
    password = params[:password]
    
    @user = User.find_by(username: username)
    
    if @user && @user.password == password
        session[:user_id] = @user.id
        "Success! User with id #{session[:user_id]} is logged in !"
        else
            @error_message = "Login failed."
            erb(:login)
        end
end

get '/logout' do
    session[:user_id] = nil
    redirect to('/')
end

get '/finstagram_posts/new' do
    
    erb(:"finstgram_posts/new")
end

post'/finstagram_posts' do
    params.to_s
end

get '/finstagram_posts/new' do
    @finstagram_post = FinstagramPost.new
    erb(:"finstagram_posts/new")
end 

post '/finstagram_posts' do
    photo_url = params[:photo_url]
    
    @finstagram_post = FinstagramPost.new({ photo_url: photo-url})
   
    if @finstagram_post.save
        redirect(to('/'))
    else
        @finstagram_post.errors.full_messages.inspect
    end
end

get '/finstagram_posts/:id' do
    @finstagram_post = FinstagramPost.find(params[:id])
 erb(:"finstagram_posts/show")
end

get '/finstagram_posts/:id' do
    @finstagram_post = FinstagramPost.find(params[:id])
    erb(:"finstagram_posts/show")
end    

post '/comments' do
    text = params[:text]
    finstagram_post_id = params[:finstagram_post_id]
    
    comment = Comment.new({ text: text, finstagram_post_id: finstagram_post_id, user_id: current_user.id})
    comment.save
    redirect(back)
end


    