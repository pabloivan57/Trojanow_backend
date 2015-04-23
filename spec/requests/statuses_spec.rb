require 'spec_helper'

describe "Status API" do
  let!(:user) { create(:user) }

  context "Statuses" do
    before do
      login_as(user, scope: :user)
    end

    describe "POST /statuses" do
      let(:status_params) do
        {
          status: {
            title: 'Test Title',
            description: 'My first post',
            status_type: 'status',
            anonymous: true,
          }
        }
      end

      let(:location_params) do
        {
            latitude: 34.022926,
            longitude: -118.285023
        }
      end

      let(:environment_params ) do
        {
            temperature: 38.00
        }
      end

      it "creates a new status" do
        json_post statuses_path, status_params, json_headers

        expect(response.status).to eq(201)
        status = user.statuses.first
        expect(status.title).to eq('Test Title')
        expect(status.description).to eq('My first post')
        expect(status.anonymous).to eq(true)
      end

      it "allows to create locations along with the status" do
        status_params[:status][:location] = location_params

        json_post statuses_path, status_params, json_headers
        expect(response.status).to eq(201)

        location = user.statuses.first.location
        expect(location.latitude).to eq(34.022926)
        expect(location.longitude).to eq(-118.285023)
      end

      it "allows to create environment along with the status" do
        status_params[:status][:environment] = environment_params

        json_post statuses_path, status_params, json_headers
        expect(response.status).to eq(201)

        environment = user.statuses.first.environment
        expect(environment.temperature).to  eq(38.00)
      end
    end
  end
end
