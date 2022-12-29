require 'rails_helper'

RSpec.describe "ski_resorts/new", type: :view do
  before(:each) do
    assign(:ski_resort, SkiResort.new(
      resort_name: "MyString",
      address: "MyString",
      hp_url: "MyText",
      phone_number: "MyString",
      business_hours: "MyString",
      business_period: "MyString",
      snow_quality: "MyString",
      resort_feature: "MyText",
      ski_lift: "MyString",
      resort_image: "MyString"
    ))
  end

  it "renders new ski_resort form" do
    render

    assert_select "form[action=?][method=?]", ski_resorts_path, "post" do

      assert_select "input[name=?]", "ski_resort[resort_name]"

      assert_select "input[name=?]", "ski_resort[address]"

      assert_select "textarea[name=?]", "ski_resort[hp_url]"

      assert_select "input[name=?]", "ski_resort[phone_number]"

      assert_select "input[name=?]", "ski_resort[business_hours]"

      assert_select "input[name=?]", "ski_resort[business_period]"

      assert_select "input[name=?]", "ski_resort[snow_quality]"

      assert_select "textarea[name=?]", "ski_resort[resort_feature]"

      assert_select "input[name=?]", "ski_resort[ski_lift]"

      assert_select "input[name=?]", "ski_resort[resort_image]"
    end
  end
end
