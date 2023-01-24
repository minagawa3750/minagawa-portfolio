require "rails_helper"

RSpec.describe SkiResort, type: :model do

  it "ゲレンデ名がなければ無効な状態であること" do
    ski_resort = SkiResort.new(resort_name: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:resort_name]).to include("を入力してください")
  end

  it "住所がなければ無効な状態であること" do
    ski_resort = SkiResort.new(address: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:address]).to include("を入力してください")
  end

  it "電話番号がなければ無効な状態であること" do
    ski_resort = SkiResort.new(phone_number: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:phone_number]).to include("を入力してください")
  end

  it "おとな料金がなければ無効な状態であること" do
    ski_resort = SkiResort.new(adult_price: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:adult_price]).to include("を入力してください")
  end

  it "こども料金がなければ無効な状態であること" do
    ski_resort = SkiResort.new(kid_price: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:kid_price]).to include("を入力してください")
  end

  it "シニア料金がなければ無効な状態であること" do
    ski_resort = SkiResort.new(senior_price: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:senior_price]).to include("を入力してください")
  end

  it "リフト数がなければ無効な状態であること" do
    ski_resort = SkiResort.new(ski_lift: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:ski_lift]).to include("を入力してください")
  end

  it "コース数がなければ無効な状態であること" do
    ski_resort = SkiResort.new(courses: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:courses]).to include("を入力してください")
  end

  it "最大傾斜がなければ無効な状態であること" do
    ski_resort = SkiResort.new(maximum_tilt: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:maximum_tilt]).to include("を入力してください")
  end

  it "最大滑走距離がなければ無効な状態であること" do
    ski_resort = SkiResort.new(maximum_distance: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:maximum_distance]).to include("を入力してください")
  end

  it "ここが特徴がなければ無効な状態であること" do
    ski_resort = SkiResort.new(resort_feature: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:resort_feature]).to include("を入力してください")
  end

  it "ここがおすすめがなければ無効な状態であること" do
    ski_resort = SkiResort.new(introduction: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:introduction]).to include("を入力してください")
  end

  it "ホームページがなければ無効な状態であること" do
    ski_resort = SkiResort.new(hp_url: nil)
    ski_resort.valid?
    expect(ski_resort.errors[:hp_url]).to include("を入力してください")
  end

  describe "#time_before_finish" do
    before do
      ski_resort.valid?
    end

    context "通過する場合" do
      let(:ski_resort) { build(:ski_resort) }
      specify "バリデーションを通過すること" do
        expect(ski_resort).to be_valid
      end
    end

    context "通過しない場合" do
      let(:ski_resort) { build(:ski_resort, :skip_validation, start_time: "16:00", end_time: "9:00") }
      specify "バリデーションを通過しないこと" do
        expect(ski_resort).to be_invalid
      end

      specify "エラーメッセージを表示させること" do
        expect(ski_resort.errors[:end_time]).to include('は開始時間以降のものを選択してください')
      end
    end
  end

  describe "#day_before_finish" do
    before do
      ski_resort.valid?
    end

    context "通過する場合" do
      let(:ski_resort) { build(:ski_resort) }

      specify "バリデーションを通過すること" do
        expect(ski_resort).to be_valid
      end
    end

    context "通過しない場合" do
      let(:ski_resort) { build(:ski_resort, :skip_validation, start_day: "2023-01-07", end_day: "2023-01-02") }

      specify "バリデーションを通過しないこと" do
        expect(ski_resort).to be_invalid
      end

      specify "エラーメッセージを表示させること" do
        expect(ski_resort.errors[:end_day]).to include("は開始日以降のものを選択してください")
      end
    end
  end
end
