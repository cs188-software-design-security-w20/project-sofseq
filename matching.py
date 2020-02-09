from collections import Counter
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.metrics.pairwise import linear_kernel

def is_from_same_country(mentee_country, mentor_country):
    ''' Checks if any mentor is from the same country. Returns boolean. '''
    if mentee_country == mentor_country:
            return True
    return False

def create_cosine_similarity(profiles):
    ''' Performs a cosine similarity of mentee with every mentor using tfidf scores '''
    mentee = profiles[0]
    mentors = profiles[1:]
    cosine_similarities = linear_kernel(mentee, mentors)
    return cosine_similarities

def transform_to_tfidf(profiles):
    ''' Return a tfidf transformed corpus '''
    vectorizer = TfidfVectorizer()
    transformed_profiles = vectorizer.fit_transform(profiles)
    return transformed_profiles

def find_top_k_indices(cosine_similarities, k):
    ''' Returns top k matches based on similarity '''
    # adding 0.1 boost for same countries
    indices = cosine_similarities.argsort()[::-1][:k]
    return indices

def find_mentor(mentee, mentors):
    ''' Matched mentor is returned as a tuple (mentee_email, mentor_email) '''
    # Makes use of goals + bio
    mentee_email = mentee[0]
    mentee_country = mentee[1]
    mentee_profile = mentee[3].strip() + ' ' + mentee[4].strip()
    mentor_profiles = []
    for mentor in mentors:
        mentor_profiles.append(mentor[3].strip() + ' ' + mentor[4].strip())
    mentor_profiles.insert(0, mentee_profile)
    transformed_profiles = transform_to_tfidf(mentor_profiles)
    cosine_similarities = create_cosine_similarity(transformed_profiles)[0]
    # Boosting for same country
    for idx,mentor in enumerate(mentors):
        mentor_country = mentor[1]
        if is_from_same_country(mentor_country, mentor_country):
            cosine_similarities[idx] += 0.1
    # Top 'k' compatible mentors
    k = 3
    top_3_indices = find_top_k_indices(cosine_similarities, k)
    matches = []
    for index in range(k):
        matches.append((mentee_email, mentors[top_3_indices[index]][0]))
    return matches

def main():
    ''' Main driver function to match a potential mentee with a list of registered mentors '''
    # All users are saved as a tuple -> (email_id, country of origin, languages spoken, goals, bio)
    mentors_list = [
                ('mentor1@gmail.com', 'Mexico', ['English','Spanish'], 
                    'I want to start my own company', 
                    '20 year old interested in CS.'),
                ('mentor2@gmail.com', 'Iran', ['English','Spanish'], 
                    "Set aside money for my children's education",
                    '20 year old interested in CS.'),
                ('mentor3@gmail.com', 'Syria', ['English','Spanish'], 
                    'I want to be an astronaut',
                    '20 year old interested in CS.'),
                ('mentor4@gmail.com', 'Canada', ['English','Spanish'], 
                    'I want to be an astronaut',
                    '20 year old interested in CS.'),
                ('mentor5@gmail.com', 'Mexico', ['English','Spanish'], 
                    'I want to be an astronaut',
                    '20 year old interested in CS.')
            ]
    mentee = ('mentee@gmail.com', 'Mexico', ['English','Spanish'], 
                    'I want to be an astronaut', 
                    '20 year old interested in CS.')
    matches = find_mentor(mentee, mentors_list)
    for match in matches:
        print(match)

if __name__ == "__main__":
    main()