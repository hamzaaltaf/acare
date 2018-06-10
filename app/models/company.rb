class Company < ActiveRecord::Base
	validates_uniqueness_of :title
  has_many :employees, dependent: :destroy
  MAPPING = {
    	"name" => "name",
    	"number" => "number"
  	}
	before_save :format_number
	
	def format_number; end

    def self.import(file, company_id)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        row.keys.each { |k| row[ MAPPING[k] ] = row.delete(k) if MAPPING[k] }
        Company.transaction do 
          employee = Employee.create(name: row['name'], number: row['number'], company_id: company_id)
        end
      end
  	end
  
  	#helper method for import
  	def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
	      when ".csv" then Roo::CSV.new(file.path, file_warning: :ignore)
	      when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
	      when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
	      else raise "Unknown file type: #{file.original_filename}"
	    end
  	end
end
