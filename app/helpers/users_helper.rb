module UsersHelper
  require 'open-uri'
  require 'net/http'

  def get_rna_asso_by_rna(rna, new_attempt = false)
    uri = URI("https://entreprise.data.gouv.fr/api/rna/v1/id/#{rna.gsub(/\s/, '')}")

    response = Net::HTTP.get(uri).force_encoding(Encoding::UTF_8)
    unless response.blank?
      begin
        json = JSON.parse(response)
      rescue JSON::ParserError => e
        return nil if new_attempt
        sleep(2)
        return get_rna_asso_by_rna(rna, true)
      end

      return nil unless json.present?

      unless json['message'].present? && json['message'] == "no results found"
        asso_infos = json['association']
        return nil if asso_infos.nil? || asso_infos['erreur'].present?

        return @infos = retrieve_asso_infos(asso_infos)
      end
    end
  end

  private

  def retrieve_asso_infos(asso_infos)
    return {
      name: asso_infos['titre'],
      official_id: asso_infos['id_association'],
      rna_id: asso_infos['id_association']
    }
  end
end
