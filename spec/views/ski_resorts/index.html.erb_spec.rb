require 'rails_helper'

RSpec.describe "ski_resorts/index", type: :view do
  before(:each) do
    assign(:ski_resorts, [
      SkiResort.create!(
        resort_name: "Resort Name",
        address: "Address",
        hp_url: "MyText",
        phone_number: "Phone Number",
        business_hours: "Business Hours",
        business_period: "Business Period",
        snow_quality: "Snow Quality",
        resort_feature: "MyText",
        ski_lift: "Ski Lift",
        resort_image: "Resort Image"
      ),
      SkiResort.create!(
        resort_name: "Resort Name",
        address: "Address",
        hp_url: "MyText",
        phone_number: "Phone Number",
        business_hours: "Business Hours",
        business_period: "Business Period",
        snow_quality: "Snow Quality",
        resort_feature: "MyText",
        ski_lift: "Ski Lift",
        resort_image: "Resort Image"
      )
    ])
  end

  it "renders a list of ski_resorts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Resort Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Business Hours".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Business Period".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Snow Quality".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Ski Lift".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Resort Image".to_s), count: 2
  end
end
