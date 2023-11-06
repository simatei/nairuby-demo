require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index, format: :json
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns a list of events' do
      create_list(:event, 3) # Assumes you have a factory for events
      get :index, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.size).to eq(3)
    end
  end

  describe 'GET #show' do
    let(:event) { create(:event) } # Assumes you have a factory for events

    it 'returns a success response' do
      get :show, params: { id: event.id }, format: :json
      expect(response).to be_successful
    end

    it 'returns the event' do
      get :show, params: { id: event.id }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(event.id)
    end
  end
end
