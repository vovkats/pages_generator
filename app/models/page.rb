class Page < ActiveRecord::Base
  has_many :sub_pages, class_name: 'Page', foreign_key: 'root_id'

  scope :root_pages, -> { where(root_id: nil) }

  validates :name, presence: true
  validate :page_name, on: :create

  serialize :path, Hash

  def main?
    root_id.nil?
  end

  def parent
    Page.find_by(id: root_id)
  end

  private

  def page_name
    if root_id
      if parent.sub_pages.where(name: name).present?
        errors[:name] << 'Root page already has parent page with this name'
      end
    else
      if Page.root_pages.where(name: name).present?
        errors[:name] << 'Root page must have uniq name'
      end
    end
  end
end
