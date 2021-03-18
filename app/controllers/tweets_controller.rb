class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        if !Helpers.is_logged_in?(session)
            redirect '/login'
        else
            erb :'tweets/index'
        end
    end

    get '/tweets/new' do
        if !Helpers.is_logged_in?(session)
            redirect '/login'
        else
            erb :'tweets/new'
        end
        #erb :'tweets/new'
    end

    post '/tweets' do
        #binding.pry
        if params[:content] == "" || params[:content] == " "
            redirect '/tweets/new'
        else
            @tweet = Tweet.new(params)
            @tweet.user_id = session[:user_id]
            @tweet.save
        end
        redirect "tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/edit'
        else
            redirect 'login'
        end
    end    

end


#    <input type="submit" name="submit">
