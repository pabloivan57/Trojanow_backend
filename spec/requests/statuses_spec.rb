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
            anonymous: true,
          }
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
    end
  end
end
