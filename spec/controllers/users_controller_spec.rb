require 'spec_helper'

describe UsersController, type: :controller do
  include_examples 'JSON API invalid request', resource: :users

  context 'when response is invalid' do
    context 'when no "json" key is present' do
      it 'renders a 500 response', :aggregate_failures do
        get :no_json_key_failure
        expect(response).to have_http_status :internal_server_error
        expect(error['title']).to eq('Internal Server Error')
        expect(error['code']).to eq(500)
        expect(error['meta']['exception']).to eq('":json" key must be set to JSONAPI::Utils#jsonapi_render')
      end
    end
  end

  describe '#index' do
    it 'renders a collection of users' do
    end

    # context 'with "fields" params' do
    # end
  end

  describe '#show' do
    context 'when resource was not found' do
      it 'renders a 400 response', :aggregate_failures do
        get :show, id: 999
        expect(response).to have_http_status :not_found
        expect(error['title']).to eq('Record not found')
        expect(error['code']).to eq(404)
      end
    end
  end
end
