# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  city       :string
#  country    :string
#  name       :string
#  subdomain  :string
#  zipcode    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  has_many :users
  has_many :pets
end
