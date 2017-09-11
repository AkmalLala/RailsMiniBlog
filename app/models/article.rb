class Article < ApplicationRecord
  has_many :comments, dependent: :destroy

  has_attached_file :img, :styles => { medium: "300x300>", homesize: "205x205>", :small => "150x150>", thumb: "100x100>" },
    :url  => "/upload_images/article/:id/:style/:basename.:extension",
    :path => ":rails_root/public/upload_images/article/:id/:style/:basename.:extension"

    validates_attachment_presence :img
    validates_attachment_size :img, :less_than => 5.megabytes
    validates_attachment_content_type :img, :content_type => ['image/jpeg', 'image/png']

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["title", "body", "author", "img_file_name", "img_content_type", "img_file_size", "img_updated_at"]
      all.each do |article|
        csv << [article.title, article.body, article.author, article.img_file_name, article.img_content_type, article.img_file_size, article.img_updated_at]
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(id: row["id"]) || new
      product.attributes = row.to_hash
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
