require 'swagger_helper'

describe 'Posts API', type: :request, swagger_doc: 'v1/swagger.json' do
  let!(:user) { create :user }
  let(:Authorization) { auth_headers(user) }

  context 'creating new comment' do
    path '/v1/posts/{id}/comments' do
      post 'Comment create' do
        tags 'Comment'
        operationId 'create_comment'
        security [bearerAuth: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :comment_payload, in: :body, schema: { '$ref' => '#/definitions/comment' }
        parameter name: :id, in: :path, type: :integer

        response '201', 'post created successfully' do
          let!(:posting) { create :post }
          let(:id) { posting.id }
          let(:comment_payload) do
            {
              comment: {
                message: 'FFaker::String'
              }
            }
          end

          run_test! do
            expect(json_response['message']).to eq 'FFaker::String'
          end
        end

        response '422', 'Returns unprocessable entity' do
          let!(:posting) { create :post }
          let(:id) { posting.id }
          let(:comment_payload) do
            {
              comment: {
                message: nil
              }
            }
          end

          run_test!
        end

        response '404', 'Returns unprocessable entity' do
          let(:id) { 0 }
          let(:comment_payload) do
            {
              comment: {
                message: 'FFaker::String'
              }
            }
          end

          run_test!
        end
      end
    end
  end

  context 'update comment' do
    path '/v1/posts/{post_id}/comments/{id}' do
      put 'Comment create' do
        tags 'Comment'
        operationId 'create_comment'
        security [bearerAuth: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :comment_payload, in: :body, schema: { '$ref' => '#/definitions/comment' }
        parameter name: :id, in: :path, type: :integer
        parameter name: :post_id, in: :path, type: :integer

        response '200', 'post updated successfully' do
          let!(:posting) { create :post }
          let(:post_id) { posting.id }
          let!(:comment) { create :comment, post: posting }
          let(:id) { comment.id }
          let(:comment_payload) do
            {
              comment: {
                message: 'FFaker::String'
              }
            }
          end

          run_test! do
            expect(json_response['message']).to eq 'FFaker::String'
          end
        end

        response '422', 'Returns unprocessable entity' do
          let!(:posting) { create :post }
          let(:post_id) { posting.id }
          let!(:comment) { create :comment, post: posting }
          let(:id) { comment.id }
          let(:comment_payload) do
            {
              comment: {
                message: nil
              }
            }
          end

          run_test!
        end

        response '404', 'Record not found' do
          let!(:posting) { create :post }
          let(:post_id) { 0 }
          let!(:comment) { create :comment, post: posting }
          let(:id) { comment.id }
          let(:comment_payload) do
            {
              comment: {
                message: nil
              }
            }
          end

          run_test!
        end
      end
    end
  end

  context 'delete comment' do
    path '/v1/posts/{post_id}/comments/{id}' do
      delete 'Destroy create' do
        tags 'Comment'
        operationId 'destroy_comment'
        security [bearerAuth: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :id, in: :path, type: :integer
        parameter name: :post_id, in: :path, type: :integer

        response '204', 'post updated successfully' do
          let!(:posting) { create :post }
          let(:post_id) { posting.id }
          let!(:comment) { create :comment, post: posting }
          let(:id) { comment.id }

          run_test!
        end

        response '404', 'Record not found' do
          let!(:posting) { create :post }
          let(:post_id) { 0 }
          let!(:comment) { create :comment, post: posting }
          let(:id) { comment.id }

          run_test!
        end
      end
    end
  end
end
