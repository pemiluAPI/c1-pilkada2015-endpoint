module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :lokasi do
      desc "Return all Pilkada Locations"
      get do
        locations = []

        search = !params[:nama].blank? ? ['name like ?', params[:nama]] : []
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Region.where(search)
          .limit(limit)
          .offset(params[:offset])
          .each do |data|
            locations << {
              id: data.id,
              nama: data.name,
              link: data.resource
            }
          end

        {
          results: {
            count: locations.count,
            total: Region.where(search).count,
            lokasi: locations
          }
        }
      end
    end

    resource :kabupaten_kota do
      desc "Rekapitulasi form C1 Pilkada 2015 per Kabupaten atau Kota"
      get do
        cities = []

         valid_params = {
          id: 'id',
          lokasi_id: 'region_id',
          lokasi: 'region_name'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        search = !params[:nama].blank? ? ['name like ?', params[:nama]] : []
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        City.where(conditions)
          .where(search)
          .limit(limit)
          .offset(params[:offset])
          .each do |data|
            cities << {
              id: data.id,
              lokasi: {
                id: data.region_id,
                nama: data.region_name,
              },
              nama_kab_kota: data.name,
              pemilih: data.pemilih,
              pengguna_hak_pilih: data.pengguna_hak_pilih,
              perolehan_suara: data.perolehan_suara,
              suara_sah: data.suara_sah,
              suara_tidak_sah: data.suara_tidak_sah,
              total_suara: data.total_suara,
              sumber: data.resource
            }
          end

        {
          results: {
            count: cities.count,
            total: City.where(conditions).where(search).count,
            data: cities
          }
        }
      end
    end

    resource :kecamatan do
      desc "Rekapitulasi form C1 Pilkada 2015 per Kecamatan"
      get do
        districts = []

         valid_params = {
          id: 'id',
          lokasi_id: 'region_id',
          lokasi: 'region_name',
          kota_id: 'city_id',
          kota: 'city_name'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        search = !params[:nama].blank? ? ['name like ?', params[:nama]] : []
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        District.where(conditions)
          .where(search)
          .limit(limit)
          .offset(params[:offset])
          .each do |data|
            districts << {
              id: data.id,
              lokasi: {
                id: data.region_id,
                nama: data.region_name,
              },
              kabupaten_kota: {
                id: data.city_id,
                nama: data.city_name,
              },
              kecamatan: data.name,
              pemilih: data.pemilih,
              pengguna_hak_pilih: data.pengguna_hak_pilih,
              perolehan_suara: data.perolehan_suara,
              suara_sah: data.suara_sah,
              suara_tidak_sah: data.suara_tidak_sah,
              total_suara: data.total_suara,
              sumber: data.resource
            }
          end

        {
          results: {
            count: districts.count,
            total: District.where(conditions).where(search).count,
            data: districts
          }
        }
      end
    end
  end
end