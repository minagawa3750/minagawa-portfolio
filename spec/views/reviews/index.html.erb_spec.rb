require 'rails_helper'

RSpec.describe "reviews/index", type: :view do
  before(:each) do
    assign(:reviews, [
      Review.create!(
        user_id: 2,
        ski_resort_id: 3,
        title: "Title",
        comment: "MyText",
        rate: 4.5
      ),
      Review.create!(
        user_id: 2,
        ski_resort_id: 3,
        title: "Title",
        comment: "MyText",
        rate: 4.5
      )
    ])
  end

  it "renders a list of reviews" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.5.to_s), count: 2
  end
end
