RSpec.describe Indieweb::PostTypes::Identifier::Read do
  context '.type_from' do
    context 'when the identifier should identify the type' do
      let(:post_data) do
        {
          "type" => ["h-entry"],
          "properties" => {
            "summary" => ["Want to read: Title by Author, ISBN: ISBN"],
            "read-status" => ["to-read"],
            "read-of" => [
              {
                "type" => ["h-cite"],
                "properties" => {
                  "name" => ["Title"],
                  "author" => ["Author"],
                  "uid" => ["isbn:ISBN"]
                }
              }
            ]
          }
        }
      end

      context "when the entry is standalone" do
        let(:data) { post_data }

        it { expect(described_class.type_from(data)).to eq('read') }
      end

      context "when the entry is within items" do
        let(:data) do
          {
            "items" => [post_data]
          }
        end

        it { expect(described_class.type_from(data)).to eq('read') }
      end
    end

    context 'when the identifier should not identify the type' do
      let(:post_data) do
        {
          "type" => ["h-entry"],
          "properties" => {
            "content" => [
              "This is an example of a note"
            ],
            "published" => [
              "2018-04-19T10:24:55+00:00"
            ]
          }
        }
      end

      context "when the entry is standalone" do
        let(:data) { post_data }

        it { expect(described_class.type_from(data)).not_to eq('read') }
      end

      context "when the entry is within items" do
        let(:data) do
          {
            "items" => [post_data]
          }
        end

        it { expect(described_class.type_from(data)).not_to eq('read') }
      end
    end
  end
end
