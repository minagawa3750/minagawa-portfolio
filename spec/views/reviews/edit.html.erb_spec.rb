require 'rails_helper'

RSpec.describe "reviews/edit", type: :view do
  let(:review) {
    Review.create!(
      user_id: 1,
      ski_resort_id: 1,
      title: "MyString",
      comment: "MyText",
      rate: 1.5
    )
  }

  before(:each) do
    assign(:review, review)
  end

  it "renders the edit review form" do
    render

    assert_select "form[action=?][method=?]", review_path(review), "post" do

      assert_select "input[name=?]", "review[user_id]"

      assert_select "input[name=?]", "review[ski_resort_id]"

      assert_select "input[name=?]", "review[title]"

      assert_select "textarea[name=?]", "review[comment]"

      assert_select "input[name=?]", "review[rate]"
    end
  end
end
