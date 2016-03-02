require 'rails_helper'

RSpec.describe Authentication, type: :model do
  context "required attributes" do
    context "uid" do
      subject { build(:authentication, uid: nil) }

      it { expect(subject.save).to be false }
    end
  end

  context "unique attributes" do
    context "uid" do
      before { create(:authentication, uid: "12345") }

      subject { build(:authentication, uid: "12345") }
      it { expect(subject.save).to be false  }
    end
  end
end
