class Employee < ActiveRecord::Base
	belongs_to :compnay
	validates_presence_of :name, :number, :company_id
	before_save :format_phone, if: :number_changed?

	def format_phone
		phone = self.number.present? ? phone_formatter(self.number) : nil
    	assign_attributes(number: phone)
	end
		
  private

	def phone_formatter(phone)
      if phone[0] == "0"
        puts "1"
        phone = "+92" + phone[1..-1]
      elsif phone[0] == "9"
        puts "2"
        phone = "+" + phone
      elsif phone[0..1] == "+0"
        puts "3"
        phone = "+92" + phone[2..-1]
      elsif phone[0..1] == "+3"
        puts "4"
        phone = "+92" + phone[1..-1]
      elsif phone[0] == "3"
        puts "5"
        phone = "+92" + phone[0..-1]
      elsif phone[0..3] == "+920"
        puts "6"
        phone = "+92" + phone[4..-1]
      else
        puts "7"
        phone = phone[0..-1]
      end
      return phone
    end
end
