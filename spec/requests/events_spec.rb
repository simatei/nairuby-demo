require 'rails_helper'

RSpec.describe "Events", type: :request do
  let!(:event) { create(:event) }

  describe "GET /index" do
    it "renders a successful response" do
      get events_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get event_path(event)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Event" do
        expect {
          post events_path, params: { event: attributes_for(:event) }
        }.to change(Event, :count).by(1)
      end

      it "redirects to the created event" do
        post events_path, params: { event: attributes_for(:event) }
        expect(response).to redirect_to(event_path(Event.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Event" do
        expect {
          post events_path, params: { event: attributes_for(:event, name: nil) }
        }.to change(Event, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { name: "Updated Event Name" } }

      it "updates the requested event" do
        patch event_path(event), params: { event: new_attributes }
        event.reload
        expect(event.name).to eq("Updated Event Name")
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e., to display the 'edit' template)" do
        patch event_path(event), params: { event: attributes_for(:event, name: nil) }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested event" do
      expect {
        delete event_path(event)
      }.to change(Event, :count).by(-1)
    end
  end
end
