FactoryGirl.define do

  factory :comment do
    sequence :title do |n|
      "Title For Comment #{n}"
    end
    thing
  end

  factory :thing do
    sequence :title do |n|
      "Title For Thing #{n}"
    end

    factory :thing_with_comments do
      transient do
        comments_count 3
      end

      after(:create) do |thing, evaluator|
        create_list(:comment, evaluator.comments_count, thing: thing)
      end
    end
  end
end