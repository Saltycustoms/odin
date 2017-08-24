class PackingList < ApplicationRecord
  acts_as_paranoid
  belongs_to :deal
  has_one :address, as: :belongable, class_name: "Address", dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many :pics, as: :belongable, class_name: "Pic", dependent: :destroy
  accepts_nested_attributes_for :pics, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  has_many :packing_list_items, dependent: :destroy
  accepts_nested_attributes_for :packing_list_items, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  enum shipping_method:{ delivery: 0, self_pick_up: 1 }
  validates :shipping_method, presence: true
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  before_save :update_packing_list_attachment

  def update_packing_list_attachment
    if upload_attachment
      byebug
      self.packing_list_items.delete_all
    else
      self.attachments.delete_all
    end
  end
end
