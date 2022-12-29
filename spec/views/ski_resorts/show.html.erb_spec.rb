require 'rails_helper'

RSpec.describe "ski_resorts/show", type: :view do
  before(:each) do
    assign(:ski_resort, SkiResort.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Resort Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Business Hours/)
    expect(rendered).to match(/Business Period/)
    expect(rendered).to match(/Snow Quality/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Ski Lift/)
    expect(rendered).to match(/Resort Image/)
  end
end
