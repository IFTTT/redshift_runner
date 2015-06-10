require "redshift_runner/version"
require "redshift_runner/connection"
require "redshift_runner/result"
require "pg"

module RedshiftRunner

  def self.exec_query(query_str, readonly=false)
    start_time = DateTime.now    
    begin
      Connection.send(readonly ? :readonly : :readwrite).send(:exec_params, query_str)
    rescue PG::Error => err
      err.result
    end
    RedshiftRunner::Result.new(result, query_str, start_time)
  end

end