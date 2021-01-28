class TweetsController < ApplicationController
  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    redirect '/login' unless session[:user_id]

    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user.id
      erb :'tweets/edit_tweet'
    else
      redirect "/tweets/#{params[:id]}"
    end
  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].blank?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content],
                            user_id: session[:user_id])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy if @tweet.user.id == session[:user_id]
    redirect '/tweets'
  end

  patch '/tweets/:id' do
    redirect '/login' unless session[:user_id]
    @tweet = Tweet.find(params[:id])

    if @tweet.user.id == session[:user_id]
      redirect "/tweets/#{params[:id]}/edit" if params[:content].blank?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{params[:id]}"
    else
      redirect '/tweets'
    end
  end
end
