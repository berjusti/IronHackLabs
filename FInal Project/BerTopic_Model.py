
from umap import UMAP
from hdbscan import HDBSCAN
from sentence_transformers import SentenceTransformer
from sklearn.feature_extraction.text import CountVectorizer

from bertopic import BERTopic
from bertopic.representation import KeyBERTInspired
from bertopic.vectorizers import ClassTfidfTransformer

import pandas as pd
df = pd.read_csv('/Users/justynakurach/Documents/GitHub/IronHackLabs/FInal Project/Ecommerce_data.csv')

# Step 1 - Extract embeddings
embedding_model = SentenceTransformer("all-MiniLM-L6-v2")

# Step 2 - Reduce dimensionality
umap_model = UMAP(n_neighbors=10, n_components=2, min_dist=0.01, metric='cosine')

# Step 3 - Cluster reduced embeddings
hdbscan_model = HDBSCAN(min_cluster_size=20, min_samples=1, metric='euclidean', cluster_selection_method='leaf', prediction_data=True)

# Step 4 - Tokenize topics
vectorizer_model = CountVectorizer(ngram_range=(1, 2), stop_words="english")

# Step 5 - Create topic representation
ctfidf_model = ClassTfidfTransformer()

# Step 6 - (Optional) Fine-tune topic representations with 
# a `bertopic.representation` model
representation_model = KeyBERTInspired()

nr_topics = 50


# deal with df if needed
if type(df['Text']) is list:
    text = df['Text']
else:
    text = df['Text'].tolist()



model = BERTopic(
    nr_topics=nr_topics,
    language='english', calculate_probabilities=True,
    embedding_model=embedding_model,          # Step 1 - Extract embeddings
    umap_model=umap_model,                    # Step 2 - Reduce dimensionality to 2D or 3D
    hdbscan_model=hdbscan_model,              # Step 3 - Identify Clusters in reduced embeddings
    vectorizer_model=vectorizer_model,        # Step 4 - Tokenize topics
    ctfidf_model=ctfidf_model,                # Step 5 - Extract topic words
  representation_model=representation_model, # Step 6 - (Optional) Fine-tune topic represenations
    verbose=True
)
topics, probs = model.fit_transform(text)