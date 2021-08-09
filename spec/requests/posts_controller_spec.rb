require 'swagger_helper'

describe 'Posts API', type: :request, swagger_doc: 'v1/swagger.json' do
  let!(:user) { create :user }
  let(:Authorization) { auth_headers(user) }

  context 'posts feed' do
    path "/v1/posts" do
      get 'posts feed' do
        security [bearerAuth: []]
        tags 'Post'
        operationId 'posts_feed'
        consumes 'application/json'
        produces 'application/json'

        context 'first' do
          response '200', 'Successfully return posts' do
            let!(:posting) { create :post }

            run_test! do
              expect(json_response["posts"].count).to eq 1
            end
          end
        end
      end
    end
  end

  context 'creating new post' do
    path '/v1/posts' do
      post 'Post create' do
        tags 'Post'
        operationId 'create_post'
        security [bearerAuth: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :post_payload, in: :body, schema: { '$ref' => '#/definitions/post' }

        response '201', 'post created successfully' do

          let(:post_payload) do
            {
              post: {
                title: 'FFaker::String',
                description: "xyz descriprion"
              }
            }
          end

          run_test! do
            expect(json_response['title']).to eq 'FFaker::String'
          end
        end

        response '422', 'Returns unprocessable entity' do
          let(:post_payload) do
            {
              post: {
                title: nil,
                description: "descriprion xyz"
              }
            }
          end

          run_test!
        end
      end
    end
  end

  context 'show post' do
    path '/v1/posts/{id}' do
      get 'post show' do
        tags 'Post'
        operationId 'show_post'
        security [bearerAuth: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :id, in: :path, type: :integer

        response '200', 'Returns success response' do
          let!(:new_post) { create :post }
          let!(:id) { new_post.id }

          run_test! do
            expect(json_response['id']).to eq new_post.id
          end
        end

        response '404', 'Returns not found response' do
          let!(:id) { 0 }

          run_test!
        end
      end
    end
  end

  context 'update post' do
    path '/v1/posts/{id}' do
      put 'Post update' do
        tags 'Post'
        operationId 'update_post'
        security [bearerAuth: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :id, in: :path, type: :integer
        parameter name: :post_payload, in: :body, schema: { '$ref' => '#/definitions/post' }

        response '200', 'post created successfully' do
          let!(:user) { create :user }
          let!(:posting) { create :post }
          let(:id) { posting.id }

          let(:post_payload) do
            {
              post: {
                title: 'FFaker::String',
                description: "descriprion xyz"
              }
            }
          end

          run_test! do
            expect(json_response['title']).to eq 'FFaker::String'
          end
        end

        response '422', 'Returns unprocessable entity' do
          let!(:user) { create :user }
          let!(:posting) { create :post }
          let(:id) { posting.id }

          let(:post_payload) do
            {
              post: {
                title: nil,
                description: "descriprion xyz"
              }
            }
          end

          run_test!
        end

        response '404', 'Record not found' do
          let(:id) { 0 }
          let(:post_payload) do
            {
              post: {
                title: nil,
                description: "descriprion xyz"
              }
            }
          end

          run_test!
        end
      end
    end
  end

  context 'destroy post' do
    path '/v1/posts/{id}' do
      delete 'destroy post' do
        tags 'Post'
        operationId 'destroy_post'
        security [bearerAuth: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :id, in: :path, type: :integer

        response '204', 'Returns success response' do
          let!(:new_post) { create :post, creator: user }
          let(:id) { new_post.id }

          run_test! do
            expect(Post.exists?(id)).to eq false
          end
        end

        response '404', 'Record not found' do
          let(:id) { 0 }

          run_test!
        end
      end
    end
  end
end
