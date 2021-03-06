# frozen_string_literal: true

class Track < ApplicationRecord
  has_one_attached :audio
  has_many :playlist_tracks, dependent: :destroy
  has_many :playlists, through: :playlist_tracks

  validates :name, presence: true, on: :update

  before_create :set_artist

  scope :search, ->(query) { where('name like :search', search: "%#{query}%") if query.present? }

  private

  def set_artist
    self.name = audio.blob.filename.to_s if audio.attached?
  end
end
