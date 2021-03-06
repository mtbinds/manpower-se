/*
 * Copyright 2012-2022 CodeLibs Project and the Others.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */
package org.codelibs.fess.query;

import org.apache.lucene.search.Query;
import org.codelibs.fess.entity.QueryContext;
import org.codelibs.fess.unit.UnitFessTestCase;
import org.opensearch.index.query.MatchPhraseQueryBuilder;
import org.opensearch.index.query.PrefixQueryBuilder;
import org.opensearch.index.query.QueryBuilder;

public class QueryCommandTest extends UnitFessTestCase {
    private QueryCommand queryCommand;

    @Override
    public void setUp() throws Exception {
        super.setUp();
        queryCommand = new QueryCommand() {
            @Override
            public QueryBuilder execute(QueryContext context, Query query, float boost) {
                return null;
            }

            @Override
            protected String getQueryClassName() {
                return null;
            }
        };
    }

    public void test_buildMatchPhraseQuery() {
        assertQueryBuilder("test", "", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("test", "test", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("test", "a", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("test", "γ", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("test", "γ’", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("test", "δΊ", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("test", "μ", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("title", "test", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("title", "a", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("title", "γ", PrefixQueryBuilder.class);
        assertQueryBuilder("title", "γγ", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("title", "γ’", PrefixQueryBuilder.class);
        assertQueryBuilder("title", "γ’γ’", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("title", "δΊ", PrefixQueryBuilder.class);
        assertQueryBuilder("title", "δΊδΊ", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("title", "μ", PrefixQueryBuilder.class);
        assertQueryBuilder("title", "μμ", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("content", "test", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("content", "a", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("content", "γ", PrefixQueryBuilder.class);
        assertQueryBuilder("content", "γγ", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("content", "γ’", PrefixQueryBuilder.class);
        assertQueryBuilder("content", "γ’γ’", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("content", "δΊ", PrefixQueryBuilder.class);
        assertQueryBuilder("content", "δΊδΊ", MatchPhraseQueryBuilder.class);
        assertQueryBuilder("content", "μ", PrefixQueryBuilder.class);
        assertQueryBuilder("content", "μμ", MatchPhraseQueryBuilder.class);
    }

    private void assertQueryBuilder(String field, String value, Class<?> clazz) {
        QueryBuilder queryBuilder = queryCommand.buildMatchPhraseQuery(field, value);
        assertEquals(clazz, queryBuilder.getClass());
    }

}
