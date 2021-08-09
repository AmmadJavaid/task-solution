require 'swagger_helper'

describe 'Sessions API', type: :request, swagger_doc: 'v1/swagger.json' do
  let(:user_password) { 'password' }
  let(:user) { create :user, password: user_password }

  describe 'Session API' do
    path '/users/sign_in' do
      post 'User Sign-in' do
        tags 'Authentication'
        operationId 'sign_in'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :sign_in, in: :body, schema: { '$ref' => '#/definitions/sign_in' }

        response '200', 'Successfull Login' do
          let(:sign_in) do
            {
              user: {
                email: user.email,
                password: user_password
              }
            }
          end

          run_test! do
            expect(response.headers.has_key?("Authorization")).to be_truthy
          end
        end
      end
    end
  end

  describe 'Registration API' do
    let(:user) { build :user }

    path '/users' do
      post 'User Sign-Up' do
        tags 'Authentication'
        operationId 'sign_up'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :sign_up, in: :body, schema: { '$ref' => '#/definitions/sign_up' }

        response '200', 'Successfull registered' do
          let(:sign_up) do
            {
              user: {
                name: user.name,
                email: user.email,
                password: 'password'
              }
            }
          end

          run_test! do
            expect(response.headers.has_key?("Authorization")).to be_truthy
          end
        end
      end
    end
  end
end
