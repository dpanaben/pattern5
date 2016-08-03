class Portfolio < ApplicationRecord
  has_many :sanitizes, dependent: :nullify
  has_many :posts
  after_create :after_create

  def after_create
    self.sanitizes.create!(:match => '\s\,|\,|\,\s', :result => '，', :description => '把 , 改成全形符號')
  end
end
