require 'rails_helper'

RSpec.describe String do
  it 'removes accents of words' do
    word = 'órgão'

    expected_result = 'orgao'

    result = word.without_accents

    expect(result).to eq(expected_result)
  end

  it 'creates resource' do
    word = 'José Inácio'

    expected_result = 'jose-inacio'

    result = word.to_resource

    expect(result).to eq(expected_result)
  end
end
