require 'rails_helper'

RSpec.describe TeamsController, type: :request do
  it 'returns correct output for single team' do
    team = create(:team)
    create(:player, team: team)
    create(:player, team: team)

    verify_endpoint "/teams/#{Team.first.id}"
  end
end