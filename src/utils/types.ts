export interface ArticleProps {
  frontmatter: {
    title: string;
    excerpt?: string;
    slug: string;
  };
}