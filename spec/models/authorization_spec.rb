require 'rails_helper'

RSpec.describe Authorization, type: :model do
  context "required attributes" do
    context "uid" do
      subject { build(:authorization, uid: nil) }

      it { expect(subject.save).to be false }
    end
  end

  context "unique attributes" do
    context "uid" do
      before { create(:authorization, uid: "12345") }

      subject { build(:authorization, uid: "12345") }
      it { expect(subject.save).to be false  }
    end
  end
end
