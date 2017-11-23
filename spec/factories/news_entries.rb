FactoryBot.define do
  factory :news_entry do
    title "News title"
    annotation "News annotation"

    factory :fetched_news_entry, class: "NewsEntry::Fetched" do
      title "Fetched news title"
      annotation "Fetched news annotation"
      published_at Time.now.in_time_zone - 10.minutes
    end

    factory :authored_news_entry, class: "NewsEntry::Authored" do
      title "Authored news title"
      annotation "Authored news annotation"
      unpublish_at Time.now.in_time_zone + 10.minutes

      trait :non_active do
        unpublish_at Time.now.in_time_zone - 1.hours
      end
    end
  end
end
