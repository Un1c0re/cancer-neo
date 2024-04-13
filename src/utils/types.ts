export interface ArticleProps {
  [x: string]: any;
    frontmatter: {
      title: string;
      excerpt?: string;
      slug: string;
    };
  }