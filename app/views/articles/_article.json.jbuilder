json.extract! article, :id, :title, :img, :body, :author, :created_at, :updated_at
json.url article_url(article, format: :json)
