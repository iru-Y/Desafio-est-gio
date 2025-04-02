from flask import Flask, request, jsonify
import pandas as pd

app = Flask(__name__)

operators_df = pd.read_csv("operators.csv")

@app.route('/search', methods=['GET'])
def search_operators():
    search_term = request.args.get('term', '')
    results = operators_df[operators_df.apply(lambda row: row.astype(str).str.contains(search_term, case=False).any(), axis=1)]
    return jsonify(results.to_dict(orient='records'))

if __name__ == '__main__':
    app.run(debug=True)