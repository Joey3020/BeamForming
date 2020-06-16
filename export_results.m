testdata_dir = 'test_data.csv';
prediction_dir = 'linesearch_predictions.xlsx';
result_file_name = 'coding_check.csv';
testdata_size = 1;
a_ = 1;
b_ = 1;
num = 64;
source_name_pred = 'horn';
source_name_true = 'uniform';

process_results(testdata_dir, prediction_dir, result_file_name, ...
                        testdata_size, a_, b_, num, source_name_pred, source_name_true);
