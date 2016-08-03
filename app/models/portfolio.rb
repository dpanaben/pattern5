class Portfolio < ApplicationRecord
  has_many :sanitizes, dependent: :nullify
  has_many :posts, dependent: :nullify
  belongs_to :cop, class_name: "User", foreign_key: :user_id
  after_create :after_create

  def after_create
    if self.cop.user?
      self.sanitizes.create!(:match => '\s\,|\,|\,\s', :result => '，', :description => '把 , 改成全形符號')
    end
  end
end
