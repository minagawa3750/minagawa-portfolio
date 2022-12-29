require 'rails_helper'

RSpec.describe "reviews/show", type: :view do
  before(:each) do
    assign(:review, Review.create!(
      user_id: 2,
      ski_resort_id: 3,
      title: "Title",
      comment: "MyText",
      rate: 4.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/4.5/)
  end
end
