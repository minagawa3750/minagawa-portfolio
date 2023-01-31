require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#page_title" do
    context "blankの場合" do
      it "SKI.comを表示すること" do
        expect(page_title("")).to eq('SKI.com')
      end
    end

    context "引数が渡されている場合" do
      it "動的に表示すること" do
        expect(page_title("title")).to eq('title - SKI.com')
      end
    end

    context "nilの場合" do
      it "SKI.comを表示すること" do
        expect(page_title(nil)).to eq('SKI.com')
      end
    end
  end
end