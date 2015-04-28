require 'spec_helper'

describe "Status API" do
  let!(:user) { create(:user) }

  context "Statuses" do
    before do
      login_as(user, scope: :user)
    end

    describe "GET /statuses" do
      let!(:poster_1) { create(:user) }
      let!(:status_1) { create(:status, status_type: 'status', user: user) }
      let!(:status_2) { create(:status, status_type: 'status', user: user) }
      let!(:status_3) { create(:status, status_type: 'event', user: user) }
      let!(:status_4) { create(:status, :anonymous, status_type: 'event', user: poster_1) }
      let!(:status_5) { create(:status, user: poster_1) }

      it "retrieves anonymous statuses and user statuses" do
         get statuses_path, json_headers

         expect(response.status).to eq(200)

         statuses = json.sort_by { |hsh| hsh["id"] }
         expect(statuses.count).to eq(4)
         status = statuses[0]
         expect(status['status_type']).to eq('status')
         expect(status['user_id']).to eq(user.id)

         status = statuses[1]
         expect(status['status_type']).to eq('status')
         expect(status['user_id']).to eq(user.id)

         status = statuses[2]
         expect(status['status_type']).to eq('event')
         expect(status['user_id']).to eq(user.id)

         status = statuses[3]
         expect(status['status_type']).to eq('event')
         expect(status['user_id']).to eq(poster_1.id)
      end

      it "retrieves only statuses types when using the param type = status" do
        get statuses_path, { type: 'status' }, json_headers

        expect(response.status).to eq(200)

        statuses = json.sort_by { |hsh| hsh["id"] }
        expect(statuses.count).to eq(2)
        status = statuses[0]
        expect(status['status_type']).to eq('status')
        expect(status['user_id']).to eq(user.id)

        status = statuses[1]
        expect(status['status_type']).to eq('status')
        expect(status['user_id']).to eq(user.id)
      end

      it "retrieves only event types when using the param type = event" do
        get statuses_path, { type: 'event' }, json_headers

        expect(response.status).to eq(200)

        statuses = json.sort_by { |hsh| hsh["id"] }
        expect(statuses.count).to eq(2)
        status = statuses[0]
        expect(status['status_type']).to eq('event')
        expect(status['anonymous']).to eq(false)
        expect(status['user_id']).to eq(user.id)

        status = statuses[1]
        expect(status['status_type']).to eq('event')
        expect(status['anonymous']).to eq(true)
        expect(status['user_id']).to eq(poster_1.id)
      end
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
