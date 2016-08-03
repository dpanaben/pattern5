class Portfolio < ApplicationRecord
  has_many :sanitizes, dependent: :nullify
  has_many :posts, dependent: :nullify
  after_create :after_create

  def after_create
    if self.user?
      self.sanitizes.create!(:match => '\s\,|\,|\,\s', :result => '，', :description => '把 , 改成全形符號')
    end
  end
end
