require 'rails_helper'

RSpec.describe 'Exams API', type: :request do
  # initialize test data
  let!(:exams) { create_list(:exam, 10) }
  let(:exam_id) { exams.first.id }

  # test suite for GET /exams
  describe 'GET /exams' do
    # HTTP GET request before each example
    before { get '/exams' }

    it 'returns exams' do
      # 'json' to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # test suite for GET /exams/:id
  describe 'GET /exams/:id' do
    # HTTP GET request before each example
    before { get "/exams/#{exam_id}" }

    context 'when the record exists' do
      it 'returns the exam' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(exam_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:exam_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Exam/)
      end
    end
  end

  # test suite for POST /exams
  describe 'POST /exams' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn PNS', created_by: "G" } }

    context 'when the request is valid' do
      before { post '/exams', params: valid_attributes }

      it 'creates an exam' do
        expect(json['title']).to eq('Learn PNS')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/exams', params: {title: 'Invalid request'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # test suite for PUT /exams/:id
  describe 'PUT /exams/:id' do
    let(:valid_attributes) { { title: 'Learn PMD'} }

    context 'when the request is valid' do
      before { put "/exams/#{exam_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # test suite for DELETE /exams/:id
  describe 'DELETE /exams/:id' do
    before { delete "/exams/#{exam_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
