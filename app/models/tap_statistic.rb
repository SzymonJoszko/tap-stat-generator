class TapStatistic < ApplicationRecord

    def generate_report_workbook
        report_name = "report#{id}"
        workbook = RubyXL::Workbook.new
        worksheet = workbook[0]
        worksheet.sheet_name = report_name
        worksheet.add_cell(0, 0, "Report for #{tap_statistic_json['username']}")
        worksheet.sheet_data[0][0].change_font_bold(true)
        worksheet.sheet_data[0][0].change_fill('D0CECD')
        worksheet.merge_cells(0, 0, 0, 1)
        worksheet.change_column_width(0, 20)
        worksheet.change_column_width(1, 20)
        current_row = 2
        worksheet.add_cell(current_row, 0, 'Frequency')
        worksheet.sheet_data[current_row][0].change_fill('D0CECD')
        worksheet.sheet_data[current_row][0].change_border(:bottom, 'thin')
        worksheet.sheet_data[current_row][0].change_border(:right, 'thin')
        worksheet.add_cell(current_row, 1, 'Response time')
        worksheet.sheet_data[current_row][1].change_fill('D0CECD')
        worksheet.sheet_data[current_row][1].change_border(:bottom, 'thin')
        tap_statistic_json['measurements'].each_with_index do |measurement, idx|
            current_row += 1
            worksheet.add_cell(current_row, 0, measurement['frequency'])
            worksheet.add_cell(current_row, 1, measurement['responseTime'])
            if idx.odd?
                worksheet.sheet_data[current_row][0].change_fill('F3F3F3')
                worksheet.sheet_data[current_row][1].change_fill('F3F3F3')
            end
        end
        workbook
    end
end
