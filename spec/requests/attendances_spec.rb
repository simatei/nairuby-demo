require 'rails_helper'

RSpec.describe "Attendances", type: :request do
  let!(:event) { create(:event) }

  describe "GET /new" do
    it "renders a successful response" do
      get new_event_attendance_path(event)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Attendance" do
        expect {
          post event_attendances_path(event), params: { attendance: attributes_for(:attendance) }
        }.to change(Attendance, :count).by(1)
      end

      it "redirects to the event page" do
        post event_attendances_path(event), params: { attendance: attributes_for(:attendance) }
        expect(response).to redirect_to(event_path(event))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Attendance" do
        expect {
          post event_attendances_path(event), params: { attendance: attributes_for(:attendance, user_name: nil) }
        }.to change(Attendance, :count).by(0)
      end
    end
  end
end
