class Slide < ActiveRecord::Base
  attr_accessible :image_content_type, :image_file_name, :image_file_size, :presentation_id, :image, :width, :height
  attr_accessor :width, :height
  belongs_to :presentation
  has_attached_file :image, :url => "/system/:hash.:extension", :storage => :s3, 
                            :styles => lambda { |slide| presentation = slide.instance
                                                        dimensions =  [presentation.width, 
                                                        presentation.height].join("x") + ">" 
                                                        { :original => dimensions, :thumb => '250x175>' 
                                                      }},
                            :bucket => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:bucket], 
                            :s3_credentials => YAML::load(File.open(Rails.root.join("config/s3.yml"))), 
                            :hash_secret => "longSecretS asdas das tring"
                            
end
