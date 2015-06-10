module RedshiftRunner
  # wrap a PG result into something we want to expose
  # Docs on the PG result class here:
  # http://deveiate.org/code/pg/PG/Result.html
  class Result
    attr_accessor :query, :pg_result, :query_started_at
    attr_reader :status, :message, :rows_affected, :results, :query_ended_at, :query_duration_seconds

    def initialize(pg_result, query, query_started_at)
      @query_started_at = query_started_at
      @query_ended_at = DateTime.now
      @query_duration_seconds = ((@query_ended_at - @query_started_at) * 24 * 60 * 60).to_f
      @status = parse_status(pg_result)
      @message = parse_message(pg_result)
      @rows_affected = parse_rows_affected(pg_result)
      @results = pg_result.to_a
      @query = query
    end

    def parse_rows_affected(pg_result)
      return nil if pg_result.nil?
      return [pg_result.ntuples, pg_result.cmd_tuples].max
    end
    
    def parse_status(pg_result)
      return nil if pg_result.nil?
      return pg_result.error_message.blank? ? 'SUCCESS' : 'ERROR'
    end

    def parse_message(pg_result)
      return nil if pg_result.nil?
      return pg_result.error_message.blank? ? pg_result.cmd_status.to_s : pg_result.error_message.to_s
    end
  end
end